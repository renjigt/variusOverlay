#include <R.h>
// #include <iostream>
#include <cstdlib>
#include <ctime>
#include <iostream>

#define HI 0.35
#define LO 0.25

#define gpuErrchk(ans) { gpuAssert((ans), __FILE__, __LINE__); }
inline void gpuAssert(cudaError_t code, const char *file, int line, bool abort=true)
{
   if (code != cudaSuccess) 
   {
      fprintf(stderr,"GPUassert: %s %s %d\n", cudaGetErrorString(code), file, line);
      if (abort) exit(code);
   }
}
/**
 * Cuda kernel to calculate delay based on alpha power law.
 * Assumption : vdd (x) / Vth(y)
 * ------------------------------
 *    | vth1  | vth2  | vth3  |
 * ------------------------------
 * vdd1 | D1  | D2  | D3  |
 * ------------------------------
 * vdd2 | D4  | D5  | D6  |
 * ------------------------------
 *
 * Delay = (vdd/(vdd-vth)^alpha)
 * @param vdd      gpu vdd array
 * @param vth      gpu vth array
 * @param alpha    gpu alpha factor
 * @param Constant gpu constant to scale delay
 * @param _DELAY_  return pointer
 * @param vdd_l    length of vdd
 * @param vth_l    length of vth
 */
extern "C" __global__ void delay(const double *vdd, const double *vth, const double alpha, const double Constant, double *_DELAY_,
                      const int vdd_l, const int vth_l) {
  int tid = threadIdx.x;
  int bid = blockIdx.x;
  int bDim = blockDim.x;
  int index = tid + (bid * bDim);
  int vddID, vthID;
  vddID = (index / vth_l);
  vthID = index % vth_l;
  double localvdd, localvth;
  if (index < (vdd_l * vth_l)) {
    localvdd = vdd[vddID];
    localvth = vth[vthID];
    _DELAY_[index] = 1/((Constant * localvdd) / pow((localvdd - localvth), alpha));
  }
}

/////////////////////////////////////
// Define interface function for R //
/////////////////////////////////////
// extern "C" 
// void alpha_power_law(double *vdd, double *vth, double *alpha, double *Constant, double *_DELAY_, int *vddl, int *vthl);

extern "C" 
void alpha_power_law(double *vdd, double *vth, double *alpha, double *Constant, double *_DELAY_, int *vddl, int *vthl) {
  ///////////////////
  // Device memory //
  ///////////////////
  double *d_vdd, *d_vth, *d_DELAY_;
  int vdd_l, vth_l;
  vdd_l = (*vddl);
  vth_l = (*vthl);

  int totalDelays = vdd_l * vth_l;
//  std::cout << "totalDelays=" << totalDelays << std::endl;
//  std::cout << "vddl=" << vdd_l << std::endl;
//  std::cout << "vthl=" << vth_l << std::endl;
//  std::cout << "Constant=" << *Constant << std::endl;
//  std::cout << "alpha=" << *alpha << std::endl;
  //////////////////////////
  // Define configuration //
  //////////////////////////
  int blockSize; // The launch configurator returned block size
  // int minGridSize; // The minimum grid size needed to achieve the
  // maximum occupancy for a full device launch
  int gridSize; // The actual grid size needed, based on input size
  
  blockSize = 1024;
  //cudaOccupancyMaxPotentialBlockSize(&minGridSize, &blockSize, delay, 0, totalDelays);
  
  // Round up according to array size
  gridSize = (totalDelays + blockSize - 1) / blockSize;
//  std::cout << "grid x block " << gridSize << "x" << blockSize << std::endl;
  cudaEvent_t start, stop;
  cudaEventCreate(&start);
  cudaEventCreate(&stop);

  gpuErrchk(cudaMalloc((void **)&d_vdd, vdd_l * sizeof(double)));
  gpuErrchk(cudaMalloc((void **)&d_vth, vth_l * sizeof(double)));
  gpuErrchk(cudaMalloc((void **)&d_DELAY_, totalDelays * sizeof(double)));

  gpuErrchk(cudaMemcpy(d_vdd, vdd, vdd_l * sizeof(double), cudaMemcpyHostToDevice));
  gpuErrchk(cudaMemcpy(d_vth, vth, vth_l * sizeof(double), cudaMemcpyHostToDevice));
  // cudaMemcpy(d_DELAY_, _DELAY_, totalDelays * sizeof(double), cudaMemcpyHostToDevice);
  
  cudaEventRecord(start);
  delay<<<gridSize, blockSize>>> (d_vdd, d_vth, (*alpha), (*Constant), d_DELAY_, vdd_l, vth_l);
  gpuErrchk( cudaPeekAtLastError() );
  // cudaDeviceSynchronize();
  cudaMemcpy(_DELAY_, d_DELAY_, totalDelays * sizeof(double), cudaMemcpyDeviceToHost);
  cudaEventRecord(stop);
  cudaEventSynchronize(stop);

  float ms = 0.0;
  cudaEventElapsedTime(&ms, start, stop);

  //////////////////
  // Debug prints //
  //////////////////
  /*
  for (int i = 0; i < vdd_l; i++){
    std::cout << vdd[i] <<"|";
  }
  std::cout << std::endl;
  for(int j= 0; j < vth_l; j++){
    std::cout << vth[j] << "|";
  }
  std::cout << std::endl;
*/
 /* int index = 0;
  for (int i = 0; i < vdd_l; i++){
    for(int j= 0; j < vth_l; j++)
    {
      index =(i * vth_l) + j;
      std::cout << _DELAY_[index] << "|";
    }
    std::cout << "\n";
  }*/

  
  std::cout << "Elapsed " << ms << "ms" << std::endl;

  cudaFree(d_vdd);
  cudaFree(d_vth);
  cudaFree(d_DELAY_);
  // cudaThreadExit();
}


#ifdef NRTEST
int main() {
  int vddl = 501;
  int vthl = 90000;

  double vddArray[vddl];
  double vddStep = (1.0 - 0.5) / vddl;
  double vddi = 0.5;

  for (int i = 0; i < vddl; i++) {
    vddArray[i] = vddi;
    vddi += vddStep;
  }

  double vthArray[vthl];
  double vthStep = (HI - LO) / vthl;
  double vthi = LO;

  for (int i = 0; i < vthl; i++) {
    vthArray[i] = vthi;
    vthi += vthStep;
  }

  double alpha = 1.1;
  double constant = 8e-10;
  int totalCount = vthl * vddl;
  std::cout << "totalCount = " << totalCount << "\n";
  double *result =new double[totalCount];
  for (int i = 0; i < totalCount; i++)
  {
    // std::cout << "|i" << i;
    result[i] = 1.0;
  }

  std::cout << std::endl;
  // double vddl_f, vthl_f;
  // vddl_f = (double)vddl;
  // vthl_f = (double)vthl;
  // alpha_power_law(vddArray, vthArray,  &alpha, &constant,result, &vddl_f, &vthl_f);
  alpha_power_law(vddArray, vthArray,  &alpha, &constant,result, &vddl, &vthl);
/*
  int index = 0;
  for (int i = 0; i < vddl; i++){
    for(int j= 0; j < vthl; j++)
    {
      index =(i * vthl) + j;
      std::cout << result[index] << "|";
    }
    std::cout << "\n";
  }
*/
  delete[] result;
  return 0;
}
#endif

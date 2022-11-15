#!/bin/bash
#SBATCH --job-name=testIHC_analysis #Name to give the job
#SBATCH --time=6:30:00 #Time to allow job to run for
#SBATCH --ntasks=10 #Number of jobs (total)
#SBATCH --output=/vast/scratch/users/whitehead/outputs/testIHC_Analysis-%A_%a.out #Where to put output logs
#SBATCH --array=1-10 #Which job numbers to run, should be number of lines in images.list file
#SBATCH --cpus-per-task=12 #Only use more than one if code is already multithreaded
#SBATCH --mem 64G #obvious
#SBATCH --mail-type=END #email when all jobs done
#SBATCH --mail-user=whitehead@wehi.edu.au #email who?

#Creates the command line argmument for the analysis, reads the taskID numbered line of the test.images file
name=$(sed -n "$SLURM_ARRAY_TASK_ID"p images.list)

#The next line is essential for conda to work in your script
source /stornext/System/data/apps/anaconda3/anaconda3-2019.03/etc/profile.d/conda.sh
conda activate bac 

#run the analysis
python IHC_DAB_Count.py "$name"

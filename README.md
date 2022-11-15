# IHC_DAB-Milton
Running DAB counts on Milton 

## What is everything
- bac_environment.yml - assist setting up conda environment so things work, may still need to install a few things with pip depending on underlying OS
- IHC_DAB_Count.py - the main analysis code
- IHC_Test.ipynb - Jupyter notebook that can help determine thresholds and make sure everything is working
- getTifs.py - Recursively search for TIF files in a base directory and save to a text file for input into submission script
- submit.sh - SBATCH submissions script to milton

### First things first
This tool is for analysing images from the 3d-histec slide scanner that have been extracted to TIF. If they're still on casecenter or are mxrs files then I suggest tackling them with Qupath

### Setting up environment
If you've not used conda on mitlon before, install it with: 
```
module load anaconda3
conda init
```
Then create an environment from the yml ```conda create env -f bac_environment.yml```

### IHC_DAB_Count.py
Relatively simple analyis script that performs DAB scoring from command line. 
Simply takes a tif file location as input and writes out a number of txt files (one for each tile - script takes care of tiling)

```python IHC_DAB_Count.py [pathToTif]```

### getTifs.py
Utilty to generate a list of images to pass to sbatch.
Optionally give output filename, defaults to images.list
```
python getTifs.py [basePath] -o [outputFilename]
```

###submit.sh

See comments in file for things to change. Things to check:
- ntasks = the number of lines in images.list (or at least the amount you want to run)
- array = The range of lines you want to run on (ie, 1-10 or 1,4,7 etc)
- the correct file list is being used (images.list etc)


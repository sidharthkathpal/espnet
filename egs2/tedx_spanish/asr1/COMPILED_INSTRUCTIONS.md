# INSTRUCTIONS AND LOCATION OF THE RESULT FILES

## LOCATION OF THE RESULTS

 - Baseline commonvoice recipe with 60 percent of the dataset - [RESULTS_base_model_60](https://github.com/sidharthkathpal/espnet/blob/master/egs2/tedx_spanish/asr1/RESULTS_base_model_60.md)
 - Baseline commonvoice recipe with 100 percent of the dataset - [RESULTS_base_model_100](https://github.com/sidharthkathpal/espnet/blob/master/egs2/tedx_spanish/asr1/RESULTS_base_model_100.md)
 - Self Supervised combination using the Fused Frontends with 60 percent of the dataset - [RESULTS_SSL_model_60](https://github.com/sidharthkathpal/espnet/blob/master/egs2/tedx_spanish/asr1/RESULTS_SSL_model_60.md)

## INSTRUCTIONS FOR RUNNING

- Data Preparation Phase:
  - For splitting the data we created the data_transcript.py file which splits our data into train/dev/test
  - We updated the data.sh file to incoporate these splits work on that basis
- Code for replicating the results:
  - IPYNB file location - 
  - We also include the jupyter notebook needed to run the results we have just shared in the above .md files

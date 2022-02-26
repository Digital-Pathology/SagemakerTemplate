# Programming instructions for training on Sagemaker

Your algorithm will get instructions from the sagemaker environment in 2 different ways. 

## 1. Environment Variables

### 1.1 Data location

The location for training and test data will be passed in as environment variables. You can configure what data to pass when you initiate the training job. But before that, your algorithm needs to know where to read the data from. If your train data in s3 is something like "s3://digpath-data/unsupervised/train", then your data will be available inside the environment as "$SM_CHANNEL_TRAIN/". You can use this code snippet to get locations:

```
import os

train_data_loc = os.getenv("SM_CHANNEL_TRAIN")
test_data_loc = os.getenv("SM_CHANNEL_TEST")
```

## 2. Command line arguments

### 2.1 Hyperparameters

Hyperparameters can be dynamically passed to your algorithm through the Estimator in the SagemakerNotebook. That is a later step and first we need to make sure our algorithm can recieve those hyperparameters and use them. As an example, this is how hyperparameters are passed into the esitmator: 

```
hyperparameters = {"epochs" : 1000, "batch_size" : 64}

estimator = Estimator(
    ......
    hyperparameters=hyperparameters,
    ......
)
```

And then your algorithm is called from the command line: 

```
python run.py --epochs 1000 --batch_size 64
```

Here is an example on how you can parse these command line arguments:

```
import argparse

parser = argparse.ArgumentParser()

parser.add_argument('--epochs', type=int, default=10)
parser.add_argument('--batch-size', type=int, default=64)

args = vars(parser.parse_args())

# args is now a dictionary with the hyperparameters
```

## 3. Output from the algorithm

After training the algorithm should save the model in "/opt/ml/model/". 

If any errors occur, write a log file in "/opt/ml/output/" and the error will be returned as FailureReason in the training job.
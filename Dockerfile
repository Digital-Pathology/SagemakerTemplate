FROM 763104351884.dkr.ecr.us-east-1.amazonaws.com/pytorch-training:1.10.0-gpu-py38-cu113-ubuntu20.04-sagemaker

# Adding code folder to path so image can find python scripts
ENV PATH="/opt/ml/code:${PATH}"

COPY code /opt/ml/code

# Directory where the code is stored
ENV SAGEMAKER_SUBMIT_DIRECTORY /opt/ml/code

# Installing all the python modules
RUN pip install https://github.com/Digital-Pathology/Filtration@main#egg=filtraion
RUN pip install https://github.com/Digital-Pathology/CustomDataset@main#egg=custom_dataset
RUN pip install https://github.com/Digital-Pathology/UnifiedImageReader@main#egg=unified_image_reader
RUN pip install https://github.com/Digital-Pathology/ModelManager@main#egg=model_manager

# Restoring conda environment from environment.yml
RUN apt update \
    && apt upgrade -y \
    && apt install -y wget python3-opencv libvips42 \
    && wget https://github.com/Digital-Pathology/dev-container/blob/main/environment.yml -P /tmp \
    && conda env update --file /tmp/environment.yml

# Python script that the container will run to train/infer
ENV SAGEMAKER_PROGRAM run.py
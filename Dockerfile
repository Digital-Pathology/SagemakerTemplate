FROM 763104351884.dkr.ecr.us-east-1.amazonaws.com/pytorch-training:1.10.0-gpu-py38-cu113-ubuntu20.04-sagemaker

# Adding code folder to path so image can find python scripts
ENV PATH="/opt/ml/code:${PATH}"

# Directory where the code is stored
ENV SAGEMAKER_SUBMIT_DIRECTORY /opt/ml/code

# Installing all the python modules
RUN pip install -e git+https://github.com/Digital-Pathology/Filtration.git@main#egg=filtration
RUN pip install -e git+https://github.com/Digital-Pathology/UnifiedImageReader.git@main#egg=unified_image_reader
RUN pip install -e git+https://github.com/Digital-Pathology/CustomDataset.git@main#egg=custom_dataset
RUN pip install -e git+https://github.com/Digital-Pathology/ModelManager.git@main#egg=model_manager

# Install C libraries
RUN apt update \
    && apt upgrade -y \
    && apt install -y python3-opencv libvips42

# Install conda and pip packages
RUN conda install -c conda-forge pyvips albumentations
RUN pip install slideio opencv-python tqdm

COPY ./code /opt/ml/code

# Python script that the container will run to train/infer
ENV SAGEMAKER_PROGRAM run.py

# SagemakerTemplate

1. Install Requirements (will be most likely taken care of by the dev-container)
   1. Docker
   2. AWS Command-Line Interface (AWS CLI)
   3. VS Code
2. Set AWS Credentials
   1. `aws configure` - this will prompt you and you'll respond with the corresponding information you can find using the upcoming instructions
   2. Open up the AWS SSO that you use to sign in >> AWS Account >> Command line or programmatic access >> Option 3
   3. The region should be set to `us-east-1`
   4. The format should be set to `json`
3. Set AWS Session Token
   1. `aws configure set aws_session_token <token>`'
   2. Check instruction 2.2 for session token
4. Log into your AWS account via Docker so Docker can push to AWS
   1. `aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 432722299252.dkr.ecr.us-east-1.amazonaws.com/sagemaker`
5. Lag into your AWS account so Docker can pull the base image provided by AWS
   1. `aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 763104351884.dkr.ecr.us-east-1.amazonaws.com/pytorch-training:1.9.1-gpu-py38-cu111-ubuntu20.04`
6. Finally build to the container host
   1. `docker build . -t 432722299252.dkr.ecr.us-east-1.amazonaws.com/sagemaker:latest`

## Push Instructions

1. Push your image to ECR
   1. `docker push 432722299252.dkr.ecr.us-east-1.amazonaws.com/sagemaker:latest`
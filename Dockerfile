FROM nvcr.io/nvidia/pytorch:21.02-py3
LABEL org.opencontainers.image.authors="h.kuijf@umcutrecht.nl"

RUN mkdir -p /home

WORKDIR /home

RUN python -m pip install -U pip


COPY requirements.txt /home/
RUN python -m pip install -r requirements.txt

COPY nnUNet /home/nnUNet
RUN cd nnUNet && pip install -e .

COPY nnUNet_trained_models /home/nnUNet_trained_models
COPY process.py /home/

ENTRYPOINT python -m process $0 $@

## ALGORITHM LABELS ##

# These labels are required
LABEL nl.diagnijmegen.rse.algorithm.name=MixMicrobleedNet

# These labels are required and describe what kind of hardware your algorithm requires to run.
LABEL nl.diagnijmegen.rse.algorithm.hardware.cpu.count=1
LABEL nl.diagnijmegen.rse.algorithm.hardware.cpu.capabilities=()
LABEL nl.diagnijmegen.rse.algorithm.hardware.memory=10G
LABEL nl.diagnijmegen.rse.algorithm.hardware.gpu.count=1
LABEL nl.diagnijmegen.rse.algorithm.hardware.gpu.cuda_compute_capability=()
LABEL nl.diagnijmegen.rse.algorithm.hardware.gpu.memory=10G
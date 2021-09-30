FROM continuumio/miniconda3

WORKDIR /

COPY env.yaml .
RUN conda env create -f env.yaml


RUN echo "conda activate myenv" >> ~/.bashrc

COPY . .

SHELL ["conda", "run", "-n", "myenv", "/bin/bash", "-c"]


RUN python -c "import matplotlib"

COPY train.py .
COPY score.py .
COPY data_processing.py .

CMD ["train.py","score.py","data_processing.py"]

ENTRYPOINT ["conda", "run", "-n", "myenv", "python3"]
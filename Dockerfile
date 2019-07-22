FROM continuumio/miniconda3:4.6.14

RUN apt-get update

ADD python/environment.yml /tmp/environment.yml
RUN conda env create -f /tmp/environment.yml

COPY python  ./home/python/

ENV PATH /opt/conda/envs/my_env/bin:$PATH
ENV PYTHONPATH='$PATH:/home/python'

RUN echo "source activate my_env && conda deactivate" >> ~/.bashrc

WORKDIR /home/python

RUN bash -c "source ~/.bashrc"
RUN bash -c "source activate $(head -1 /tmp/environment.yml | cut -d' ' -f2)"

ENTRYPOINT ["python", "run.py"]

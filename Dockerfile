FROM python:3.8

WORKDIR /app

RUN apt-get update && \
    apt-get install -y git

RUN git clone https://github.com/shahzaib-123/DevOpsAssignment3.git
RUN cd /app/DevOpsAssignment3
RUN pip install --upgrade pip
RUN pip install flask
RUN pip install scikit-learn
RUN pip install pandas
RUN pip install pytest
RUN pip install flake8
RUN pip install mysql-connector-python

EXPOSE 5000

ENV NAME World

CMD ["python3", "/app/DevOpsAssignment3/app.py"]

FROM python:3.8

WORKDIR /app

RUN apt-get update && \
    apt-get install -y git

RUN git clone https://github.com/shahzaib-123/DevOpsAssignment3.git

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000

ENV NAME World

CMD ["python3", "app.py"]

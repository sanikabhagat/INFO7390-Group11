# Use an official Python runtime as a parent image
FROM python:3.6-slim

USER root

# Set the working directory to /app
# WORKDIR /app

# Copy the current directory contents into the container at /app
# ADD . /app

# Install any needed packages specified in requirements.txt
# RUN pip install -r requirements.txt

RUN pip3 install ipython
RUN pip3 install numpy
RUN pip3 install pandas
RUN pip3 install scikit-learn
RUN pip3 install BeautifulSoup4
RUN pip3 install scipy
RUN pip3 install lxml
RUN pip3 install boto3


RUN pip3 install awscli

EXPOSE 8888

WORKDIR /src/

RUN mkdir /src/assign_1
RUN mkdir /src/assign_1/out


ADD web_scrape.sh /src/assign_1 
ADD web_scrape.py /src/assign_1

RUN chmod +x /src/assign_1/web_scrape.sh
RUN chmod +x /src/assign_1/web_scrape.py

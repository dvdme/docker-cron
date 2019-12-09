FROM python:3.8-buster

LABEL maintainer=david@dme.ninja
LABEL version="0.1"
LABEL description="Run a python script as a cronjob. Edit script.py for the python script \
                   and crontab for the cron entry. This might be useful for tasks such as \
                   periodicly downloading some content to a shared volume."

# Copy crontab file in the cron directory
COPY crontab /etc/cron.d/py-cron

# Copy script requirements.txt
COPY requirements.txt /requirements.txt

# Copy python script to be used in cron
COPY script.py /script.py

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/py-cron

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Install Cron
RUN apt-get update
RUN apt-get -y install cron

# Create virtualenv 
RUN pip3 install virtualenv
RUN virtualenv --python=/usr/bin/python3 /venv

# Install script requirements.txt
RUN /venv/bin/pip install -r requirements.txt

# Run the command on container startup
CMD ["cron","-f"]


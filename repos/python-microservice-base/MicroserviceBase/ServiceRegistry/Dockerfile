# Set arguments
ARG BASE_CONTAINER=mcr.microsoft.com/windows/servercore:ltsc2022

# Set the base image
FROM $BASE_CONTAINER

# Adds metadata to image
LABEL maintainer="Thomas"

# Install Python and other necessary dependencies
RUN powershell -Command `
    curl.exe -o python-installer.exe https://www.python.org/ftp/python/3.9.7/python-3.9.7-amd64.exe; `
    Start-Process python-installer.exe -ArgumentList '/quiet InstallAllUsers=1 PrependPath=1' -Wait; `
    Remove-Item -Force python-installer.exe; `
    pip install --upgrade pip

# Make a directory for our app
WORKDIR C:\MicroserviceClewareSwitch

# Install dependencies
COPY requirements.txt .

RUN pip install -r requirements.txt

# Copy source code
COPY . .

# Run the application
CMD ["python", "ServiceRegistry.py"]

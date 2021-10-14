FROM python:2

WORKDIR /usr/src/app

RUN pip install modbus_tk pyserial
RUN apt-get install -y git

RUN git clone https://github.com/sunspec/pysunspec
WORKDIR pysunspec
RUN python2 setup.py install

WORKDIR /usr/src/app
RUN git clone https://github.com/sunspec/device-webprobe
WORKDIR device-webprobe/modsim
RUN ["chmod", "+x", "modsim.py"]
EXPOSE 502
WORKDIR /usr/src/app/device-webprobe/modsim

CMD ["modsim.py", "-m", "tcp", "-v", "1", "-i", "1", "/usr/src/app/device-webprobe/modsim/mbmap_test_device.xml"]
ENTRYPOINT ["python2"]
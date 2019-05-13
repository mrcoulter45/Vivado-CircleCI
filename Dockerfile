FROM ubuntu:18.04

# run 'chmod 777 Xilinx_Vivado_SDK_2018.3_1207_2324.tar.gz' before building
# BUILD WITH 'sudo docker build --network="host" -t vivado .'

#install dependences for:
# * downloading Vivado (wget)
# * xsim (gcc build-essential to also get make)
# * MIG tool (libglib2.0-0 libsm6 libxi6 libxrender1 libxrandr2 libfreetype6 libfontconfig)
# * CI (git)
RUN apt-get update && apt-get install -y \
  wget \
  build-essential \
  libglib2.0-0 \
  libsm6 \
  libxi6 \
  libxrender1 \
  libxrandr2 \
  libfreetype6 \
  libfontconfig \
  git

# copy in config file
COPY install_config.txt /

# download and run the install
RUN echo "Downloading Xilinx_Vivado_SDK_2018.3_1207_2324.tar.gz from http://localhost:8000/" && \
  wget http://localhost:8000/Xilinx_Vivado_SDK_2018.3_1207_2324.tar.gz -q && \
  echo "Extracting Vivado tar file" && \
  tar xzf /Xilinx_Vivado_SDK_2018.3_1207_2324.tar.gz && \
  /Xilinx_Vivado_SDK_2018.3_1207_2324/xsetup --agree 3rdPartyEULA,WebTalkTerms,XilinxEULA --batch Install --config /install_config.txt && \
  rm -rf /Xilinx_Vivado_SDK_2018.3_1207_2324*
#make a Vivado user
RUN adduser --disabled-password --gecos '' vivado
USER vivado
WORKDIR /home/vivado
#add vivado tools to path
RUN echo "source /opt/Xilinx/Vivado/2018.3/settings64.sh" >> /home/vivado/.bashrc

#copy in the license file
RUN mkdir /home/vivado/.Xilinx
COPY Xilinx.lic /home/vivado/.Xilinx/

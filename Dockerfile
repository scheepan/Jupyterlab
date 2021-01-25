FROM ubuntu:20.10

# Set maintainer
LABEL maintainer='scheepan <scheepan@web.de>'

WORKDIR /root/jupyter-lab/

RUN apt update && apt install -y curl python3-pip
RUN pip3 install jupyterlab

RUN curl -sL https://deb.nodesource.com/setup_15.x | bash -
RUN apt install -y nodejs

RUN npm install -g --unsafe-perm ijavascript
RUN ijsinstall --install=global

COPY requirements.txt ./

RUN pip3 install --upgrade pip && \
    pip3 install --no-cache-dir -r requirements.txt

COPY . .

# Build the lab
RUN jupyter lab build --minimize=False

# Expose port and path
EXPOSE 8888
VOLUME /appdata

# Add packages and functionalities
# ENV pkgs=PACKAGES
# CMD pacman --noconfirm -S 

# Run JupyterLab
CMD cp -R -n /usr/share/jupyter/* /appdata && jupyter lab --ip=* --port=8888 --no-browser --notebook-dir=/opt/app/data --allow-root --app-dir=/appdata/lab

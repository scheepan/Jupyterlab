# Use archlinux:latest as parent image
FROM archlinux:latest

# Set maintainer
LABEL maintainer='scheepan <scheepan@web.de>'

# Update mirrors and packages. Install jupyterlab
RUN pacman --noconfirm -Syyu python-pip
RUN pacman --noconfirm -Syyu jupyterlab

COPY requirements.txt ./

RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

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

FROM jupyter/tensorflow-notebook

# Set maintainer
LABEL maintainer='scheepan <scheepan@web.de>'


RUN jupyter labextension install @jupyterlab/git && \
    npm cache clean --force && \
    rm -rf $CONDA_DIR/share/jupyter/lab/staging

COPY requirements.txt ./

RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

COPY . .

# Expose port and path
EXPOSE 8888
VOLUME /appdata

# Add packages and functionalities
# ENV pkgs=PACKAGES
# CMD pacman --noconfirm -S 

# Run JupyterLab
CMD cp -R -n /home/jovyan/JupyterLabRoot* /appdata && jupyter lab --ip=* --port=8888 --no-browser --notebook-dir=/opt/app/data --allow-root

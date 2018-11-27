import io
from ftplib import FTP
import zipfile
import os


BASE_URL = "webftp.vancouver.ca"
FILENAME = "csv_street_trees.zip"
TREE_FILENAME = "OpenData/csv/" + FILENAME
PATH = os.path.join('data')

ftp = FTP(BASE_URL)
ftp.login()


# Download zip file over FTP and save locally in current directory
ftp.retrbinary('RETR {}'.format(TREE_FILENAME),
               open(FILENAME,'wb').write)

# Unzip
with zipfile.ZipFile(FILENAME, 'r') as zip_ref:
    zip_ref.extractall(PATH)

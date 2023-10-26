import os
import zipfile
fp = 'scratch/input/osm/'
s = os.listdir(fp)
for n in s:
    p = n.split('-')
    print(n)
    print(p[0])
    z = zipfile.ZipFile(f"{fp}/{n}")
    z.extractall(path=fp)
    for zmn in z.namelist():
        os.rename(f"{fp}/{zmn}",
                f"{fp}/{p[0]}_{zmn}")

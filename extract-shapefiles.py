import os
import zipfile
fp = 'preprocessing/input/osm/'
s = os.listdir(fp)
for n in s:
    if not '.zip' in n:
        continue
    p = n.split('-')
    print(n)
    print(p[0])
    z = zipfile.ZipFile(f"{fp}/{n}")
    z.extractall(path=fp)
    for zmn in z.namelist():
        if not os.path.exists(f"{fp}/{p[0]}_{zmn}"):
            os.rename(f"{fp}/{zmn}",
                    f"{fp}/{p[0]}_{zmn}")

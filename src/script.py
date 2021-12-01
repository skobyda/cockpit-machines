import requests
import sys

print(len(sys.argv))
url = str(sys.argv[1])
print(url)
dst = str(sys.argv[2])
print(dst)
ca_certificate = str(sys.argv[3])
print(ca_certificate)
pub_cert = str(sys.argv[4])
print(pub_cert)
priv_key = str(sys.argv[5])
print(priv_key)

r = requests.get(url, cert=(pub_cert, priv_key), verify=(ca_certificate), stream=True)

with open(dst, "wb") as f:
    downloaded_length = 0
    total_length = int(r.headers.get('content-length'))
    done = -1
    for data in r.iter_content(chunk_size=4096):
        downloaded_length += len(data)
        f.write(data)
        new_done = int(downloaded_length / total_length * 100)
        if (new_done > done):
            done = new_done
            sys.stdout.write("\r%s" % done)    
            sys.stdout.flush()

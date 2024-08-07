# Quick Setup

`git clone` this repo locally. 

Then, in Linux CLI, `cd` to this repo's directory and do:
```bash
docker build -t docker_quarto_image .
```

Then (assuming `9000` port is not taken; otherwise choose another port):
```bash
docker run -p 9000:80 docker_quarto_image
```

Then navigate to this URL in your browser:
```
http://0.0.0.0:9000/index.html
```
Or whatever port you may have chosen instead of `9000`


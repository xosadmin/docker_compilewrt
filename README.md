# docker_compilewrt
A container to compile OpenWrt by Docker

### Usage  
  
To run this compiler in Docker, following base command will be used:  
``docker run -d --name foo -v /path/to/source/code:/compile -v /path/to/output/storage:/output -v /path/to/pre_or_post_run:/config xosadmin/docker-compilewrt:latest``
  
Notes: 
- For directories, ``/compile`` and ``/output`` are required. The ``/config`` is option.
- The pre-compile script should be named as ``precompile.sh``
- The post-compile script should be named as ``postcompile.sh``
- The pre and post compile script must be in ``/config`` folder within docker container
  
Optional environment variable(s):  
- ``NPROC``: To define how many thread(s) will be used while compling. The default value is ``1``.  
  
Enjoy~  
  

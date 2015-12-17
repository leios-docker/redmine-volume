# Pull base image.
FROM busybox

# Define mountable directories.
VOLUME ["/redmine/config", "/redmine/files", "/redmine/plugins", "/redmine/repo", "/redmine/log"]

# Define working directory.
WORKDIR /redmine

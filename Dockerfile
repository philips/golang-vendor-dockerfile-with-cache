# Use the official Golang image to create a build artifact.
# This is based on Debian and sets the GOPATH to /go.
# https://hub.docker.com/_/golang
FROM golang:1.14 as builder

WORKDIR /app

# Create static binaries
ENV CGO_ENABLED=0

# Precompile go std library
RUN go install -v -a std

# Cache dependencies
COPY vendor ./vendor/
COPY go.* ./

# Install all modules and use `|| true` to ignore errors in case of build constraints
RUN grep -v '#' vendor/modules.txt  | xargs -I{} ash -c "go build -mod=vendor -a -v -i {} || true"

# Copy local code to the container image.
COPY . ./

# Build the binary.
RUN go build -mod=vendor -v -o server

# Use the official Alpine image for a lean production container.
# https://hub.docker.com/_/alpine
# https://docs.docker.com/develop/develop-images/multistage-build/#use-multi-stage-builds
FROM alpine:3
RUN apk add --no-cache ca-certificates

# Copy the binary to the production image from the builder stage.
COPY --from=builder /app/server /server

# Run the web service on container startup.
CMD ["/server"]

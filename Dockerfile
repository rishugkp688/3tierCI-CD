# ----------- STAGE 1: Build Go App with CGO -----------
FROM golang:1.24.5 as builder

WORKDIR /app

COPY backend/go.mod backend/go.sum ./
RUN go mod download

COPY backend/*.go ./
RUN go build -o server

# ----------- STAGE 2: Use same base to avoid GLIBC mismatch -----------
FROM golang:1.24.5

WORKDIR /root/

# Install SQLite and deps
RUN apt-get update && \
    apt-get install -y sqlite3 libsqlite3-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy Go binary
COPY --from=builder /app/server .

# Copy frontend
COPY frontend/ ./frontend/

EXPOSE 8080

CMD ["./server"]

# Proglog

A distributed commit log service built in Go, following the curriculum in "Distributed Services with Go" by Travis Jeffery.

## Overview

Proglog is a hands-on learning project that demonstrates core concepts in building distributed systems. Through this project, you'll learn how to design and implement a reliable, scalable logging service that can handle persistent storage, networking, replication, and clustering.

## Features

- **Commit Log Storage**: Append-only log for durability and consistency
- **Client-Server Architecture**: gRPC-based communication between clients and services
- **Replication**: Multi-node replication for fault tolerance
- **Clustering**: Coordinated service discovery and cluster management
- **Distributed Consensus**: Leader election and data consistency across nodes

## Prerequisites

- Go 1.16 or later
- Basic understanding of distributed systems concepts
- Familiarity with Go fundamentals

## Getting Started

### Installation

```bash
git clone https://github.com/yourusername/proglog.git
cd proglog
```

### Building

```bash
go build ./...
```

### Running

```bash
go run ./cmd/server
```

## Project Structure

```
proglog/
├── cmd/              # Command-line tools
├── internal/         # Internal packages
│   ├── log/         # Log storage implementation
│   ├── server/      # Server logic
│   └── agent/       # Distributed agent
├── go.mod
└── README.md
```

## Learning Path

This project is structured around the chapters in "Distributed Services with Go":

1. **Getting Started**: Basic project setup and structure
2. **Commit Log**: Implement persistent log storage
3. **Networking**: Build a gRPC server for client communication
4. **Replication**: Add multi-node replication capabilities
5. **Clustering**: Implement service discovery and coordination

## Resources

- [Distributed Services with Go](https://pragprog.com/titles/tjgo/distributed-services-with-go/) by Travis Jeffery
- [Go Documentation](https://golang.org/doc/)
- [gRPC Documentation](https://grpc.io/)

## License

This project is for educational purposes.

## Contributing

Feel free to fork, experiment, and extend this project as part of your learning journey!

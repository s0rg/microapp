package main

import (
	"io"
	"log"
	"net/http"
	"os"
	"os/user"
)

var (
	GitHash   string
	BuildDate string
)

func main() {
	host, err := os.Hostname()
	if err != nil {
		log.Fatal("hostname:", err)
	}

	usr, err := user.Current()
	if err != nil {
		log.Fatal("user:", err)
	}

	banner := "microapp from: " + host

	http.HandleFunc("/", func(w http.ResponseWriter, _ *http.Request) {
		_, _ = io.WriteString(w, banner)
	})

	http.HandleFunc("/health", func(w http.ResponseWriter, _ *http.Request) {
		w.WriteHeader(http.StatusNoContent)
	})

	addr := os.Getenv("ADDR")
	if addr == "" {
		addr = "0.0.0.0:8080"
	}

	log.Println("microapp git:", GitHash, "build at:", BuildDate)
	log.Println("user:", usr.Username)
	log.Println("serving on:", addr)

	if err = http.ListenAndServe(addr, nil); err != nil {
		log.Fatal(err)
	}
}

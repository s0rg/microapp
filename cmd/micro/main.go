package main

import (
	"io"
	"log"
	"net/http"
	"os"
	"os/user"
)

func main() {
	host, err := os.Hostname()
	if err != nil {
		log.Fatal("hostname:", err)
	}

	user, err := user.Current()
	if err != nil {
		log.Fatal("user:", err)
	}

	banner := "microapp from: " + host + " user: " + user.Username

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

	log.Printf("%s serving on %s", banner, addr)

	if err = http.ListenAndServe(addr, nil); err != nil {
		log.Fatal(err)
	}
}

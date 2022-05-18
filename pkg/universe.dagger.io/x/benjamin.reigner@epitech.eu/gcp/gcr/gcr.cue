// Google Container Registry
package gcr

import (
	"universe.dagger.io/docker"
	"universe.dagger.io/x/benjamin.reigner@epitech.eu/gcp"
)

// Credentials retriever for GCR
#Credentials: {
	// GCP Config
	config: gcp.#Config

	_gcloud: gcp.#GCloud & {
		"config": config
	}

	// GCR registry secret
	_run: docker.#Run & {
		input: _gcloud.output
		command: {
			name: "/bin/bash"
			args: [
				"--noprofile",
				"--norc",
				"-eo",
				"pipefail",
				"-c",
				"printf $(gcloud auth print-access-token) > /token.txt"
			]
		}
	}

	output: _run.output
}
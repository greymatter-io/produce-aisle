// All Grey Matter config objects for core componenents drawn together
// for simultaneous deployment.

// EXPORT.cue is the finalized configuration file that gets read by a GitOPS
// tool to import and sync configuration with a remote deployed Grey Matter
// instance.

// You may specify which array of configs you'd like to sync or bundle them all
// in one. We recommend splitting out your configs through namespaces such as
// core services, business applications, etc...

// example evaluation commands:
// cue eval -c EXPORT.cue --out yaml -e grocerylist_config
// cue eval -c EXPORT.cue --out json -e configs

// This package name refers to your target mesh. We are attempting to write
// configs for the "gitops-plus" Grey Matter mesh so we all our top level
// package "gitops-plus". This does not need to match the cue module name.
package grocerylist

import (
	// Point to the services folder in the mesh package since that's where we actually 
	// define our mesh configs for individual applications.
	core "examples.local/greymatter/core:examples"
	grocerylist "examples.local/greymatter/grocerylist:examples"
)

grocerylist_config:
	grocerylist.Banana.config +
	grocerylist.Apple.config +
	grocerylist.Lettuce.config +
	grocerylist.Tomato.config

configs:
	// The edge config must come first because services create routes
	// that reference the edge domain.
	core.Edge.config + grocerylist_config

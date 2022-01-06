package cmd

import (
	"github.com/spf13/cobra"
)

var (
	v2Api     = "/api/v2.0"
	harborCmd = &cobra.Command{
		Use:   "harbor",
		Short: "Interact with a Harbor docker registry",
		Long:  "Allows certain interations with a Harbor docker registry to manage build images.",
	}
)

func init() {
	rootCmd.AddCommand(harborCmd)
}

//
// Licensed Materials - Property of IBM
//
// (c) Copyright IBM Corp. 2021.
//

package cmd

import (
	"fmt"
	"os"

	"github.com/spf13/cobra"
)

var rootCmd = &cobra.Command{
	Use:   "galasabld",
	Short: "Build utilities for Galasa",
	Long:  "",
}

func Execute() {
	if err := rootCmd.Execute(); err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
}

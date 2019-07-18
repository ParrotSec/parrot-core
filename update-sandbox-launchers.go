package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"os/exec"
	"os/user"
)

type launcher struct {
	name     string
	exec     string
	filename string
}

func main() {
	if uid, _ := user.Current(); uid.Uid != "0" {
		os.Stderr.WriteString(fmt.Sprintf("Wrong user %s! - Run this program as root\n", uid.Name))
		os.Exit(1)
	}

	// run firecfg
	if _, err := os.Stat("/usr/bin/firecfg"); os.IsNotExist(err) {
		exec.Command("/usr/bin/firecfg", "--bindir=/sandbox").Output()
	}

	// scan generated aliases
	aliases, err := ioutil.ReadDir("/sandbox/")
	if err != nil {
		log.Fatal(err)
	}

	launchers := make([]launcher, len(aliases))

	// prepare new launchers
	for i, ii := range aliases {
		launchers[i].exec = fmt.Sprintf("/sandbox/%s", ii.Name())
		launchers[i].name = ii.Name()
		launchers[i].filename = fmt.Sprintf("_sandbox-%s.desktop", ii.Name())
	}

	// remove old launchers
	exec.Command("bash", "-c", "rm", "/usr/share/applications/_sandbox-*.desktop").Output()

	// create new launchers
	for _, jj := range launchers {
		content := fmt.Sprintf("#!/usr/bin/env xdg-open\n[Desktop Entry]\nEncoding=UTF-8\nIcon=parrot-menu.png\nStartupNotify=false\nType=Application\nCategories=sandbox\nTerminal=true\nName=%s\nExec=%s\n", jj.name, jj.exec)

		f, err := os.Create(jj.filename)
		if err != nil {
			log.Fatal(err)
		}
		defer f.Sync()
		defer f.Close()

		f.WriteString(content)
	}
}

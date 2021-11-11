// TODO: README/Makefile, windows/mac/linux installer|prebuild

package main

import (
	"ASMSHELL/arch"
	"ASMSHELL/utils"
	"ASMSHELL/utils/ishell"
	"flag"
	"strings"
)

var (
	mc     arch.Machine
	shell  *ishell.Shell
	pallet utils.Pallet
)

func main() {
	archStrings := strings.Join([]string{
		"Details of supported Architecture: \n",
		"    i8086         : Intel 16-bit. iAPX 86. little endian\n",
		"    x86           : Intel 32-bit. 80386/IA-32. Extended i8086 to 32-bits. little endian\n",
		"    x64           : Intel 64-bit. AMD64. Extended x86 to 64-bits. little endian\n",
		"    thumb(be)     : Arm Thumb mode(including Thumb-2). Mainly 16-bit. thumbbe is big endian\n",
		"    arm(be)       : Advanced RISC Machine. 32-bit. armbe is big endian\n",
		//        "    arm64(be)     : Armv8, 64-bit. arm64be is big endian\n",
		"    arm64         : Armv8, 64-bit\n",
		"    mips(be)      : MIPS, 32-bit. mipsbe is big endian\n",
		"    mips64(be)    : MIPS, 64-bit. mips64be is big endian\n",
		"    sparc(el)     : SPARC, 32-bit. sparcel only supports assembly. sparcel is little endian\n",
		"    sparc64       : SPARC, 64-bit. big-endian\n",
		"    powerpc       : Support assemble only. PowerPC, 32-bit. big-endian\n",
		"    powerpc64(el) : Support assemble only. PowerPC, 64-bit. powerpc64el is little endian\n",
		"    systemZ       : Support assemble only. Architecture for IBM eServer zSeries. big-endian\n",
	}, "")
	var optArch = flag.String("arch", "x86", "Simulator architecture\n"+archStrings)
	flag.Parse()
	pallet = utils.InitPallet()
	mc = arch.SetArch(*optArch)
	shell = initShell(mc.Prompt)
	shell.Run()
	shell.Close()
	finish()
}

func finish() {
	mc.Finalize()
	shell.Println("May the force be with you.")
}

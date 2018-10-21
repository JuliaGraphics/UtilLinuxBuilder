# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
using BinaryBuilder

name = "UtilLinux"
version = v"2.32.0"

# Collection of sources required to build UtilLinux
sources = [
    "https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.32/util-linux-2.32.tar.gz" =>
    "ce43afee3182f1bddb0be83f68bd378770efb9b6fdd8f464333ff8e07903db56",

]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir/util-linux-2.32
./configure --prefix=$prefix --host=$target
make
make install

"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = [
    Linux(:i686, libc=:glibc),
    Linux(:x86_64, libc=:glibc),
    Linux(:aarch64, libc=:glibc),
    Linux(:armv7l, libc=:glibc, call_abi=:eabihf),
    Linux(:powerpc64le, libc=:glibc),
    Linux(:i686, libc=:musl),
    Linux(:x86_64, libc=:musl),
    Linux(:aarch64, libc=:musl),
    Linux(:armv7l, libc=:musl, call_abi=:eabihf)
]

# The products that we will ensure are always built
products(prefix) = [
    ExecutableProduct(prefix, "chmem", :chmem),
    ExecutableProduct(prefix, "rfkill", :rfkill),
    ExecutableProduct(prefix, "fincore", :fincore),
    ExecutableProduct(prefix, "lslogins", :lslogins),
    ExecutableProduct(prefix, "fsfreeze", :fsfreeze),
    LibraryProduct(prefix, "libmount", :libmount),
    ExecutableProduct(prefix, "lsns", :lsns),
    ExecutableProduct(prefix, "losetup", :losetup),
    ExecutableProduct(prefix, "fdisk", :fdisk),
    ExecutableProduct(prefix, "mesg", :mesg),
    ExecutableProduct(prefix, "switch_root", :switch_root),
    ExecutableProduct(prefix, "lscpu", :lscpu),
    ExecutableProduct(prefix, "utmpdump", :utmpdump),
    ExecutableProduct(prefix, "partx", :partx),
    ExecutableProduct(prefix, "col", :col),
    ExecutableProduct(prefix, "swaplabel", :swaplabel),
    ExecutableProduct(prefix, "swapoff", :swapoff),
    ExecutableProduct(prefix, "whereis", :whereis),
    ExecutableProduct(prefix, "uuidgen", :uuidgen),
    ExecutableProduct(prefix, "ldattach", :ldattach),
    ExecutableProduct(prefix, "mkfs", :mkfs_bfs),
    ExecutableProduct(prefix, "renice", :renice),
    ExecutableProduct(prefix, "addpart", :addpart),
    ExecutableProduct(prefix, "mount", :mount),
    ExecutableProduct(prefix, "mkfs", :mkfs),
    ExecutableProduct(prefix, "findfs", :findfs),
    ExecutableProduct(prefix, "hwclock", :hwclock),
    ExecutableProduct(prefix, "findmnt", :findmnt),
    ExecutableProduct(prefix, "ionice", :ionice),
    ExecutableProduct(prefix, "blkdiscard", :blkdiscard),
    ExecutableProduct(prefix, "kill", :kill),
    ExecutableProduct(prefix, "fallocate", :fallocate),
    ExecutableProduct(prefix, "resizepart", :resizepart),
    ExecutableProduct(prefix, "sulogin", :sulogin),
    ExecutableProduct(prefix, "fsck", :fsck),
    ExecutableProduct(prefix, "lslocks", :lslocks),
    ExecutableProduct(prefix, "colcrt", :colcrt),
    ExecutableProduct(prefix, "blkid", :blkid),
    ExecutableProduct(prefix, "uuidd", :uuidd),
    ExecutableProduct(prefix, "hexdump", :hexdump),
    ExecutableProduct(prefix, "rev", :rev),
    ExecutableProduct(prefix, "delpart", :delpart),
    ExecutableProduct(prefix, "rename", :rename),
    ExecutableProduct(prefix, "taskset", :taskset),
    ExecutableProduct(prefix, "pivot_root", :pivot_root),
    ExecutableProduct(prefix, "lsblk", :lsblk),
    LibraryProduct(prefix, "libblkid", :libblkid),
    ExecutableProduct(prefix, "script", :script),
    ExecutableProduct(prefix, "chcpu", :chcpu),
    LibraryProduct(prefix, "libsmartcols", :libsmartcols),
    LibraryProduct(prefix, "libuuid", :libuuid),
    ExecutableProduct(prefix, "dmesg", :dmesg),
    ExecutableProduct(prefix, "swapon", :swapon),
    ExecutableProduct(prefix, "rtcwake", :rtcwake),
    ExecutableProduct(prefix, "isosize", :isosize),
    ExecutableProduct(prefix, "getopt", :getopt),
    ExecutableProduct(prefix, "wall", :wall),
    ExecutableProduct(prefix, "ipcrm", :ipcrm),
    ExecutableProduct(prefix, "fdformat", :fdformat),
    ExecutableProduct(prefix, "mountpoint", :mountpoint),
    ExecutableProduct(prefix, "nologin", :nologin),
    ExecutableProduct(prefix, "ipcmk", :ipcmk),
    ExecutableProduct(prefix, "blkzone", :blkzone),
    ExecutableProduct(prefix, "blockdev", :blockdev),
    ExecutableProduct(prefix, "setarch", :setarch),
    ExecutableProduct(prefix, "nsenter", :nsenter),
    ExecutableProduct(prefix, "setsid", :setsid),
    ExecutableProduct(prefix, "flock", :flock),
    ExecutableProduct(prefix, "raw", :raw),
    ExecutableProduct(prefix, "ctrlaltdel", :ctrlaltdel),
    ExecutableProduct(prefix, "zramctl", :zramctl),
    ExecutableProduct(prefix, "lsmem", :lsmem),
    ExecutableProduct(prefix, "cal", :cal),
    ExecutableProduct(prefix, "umount", :umount),
    ExecutableProduct(prefix, "mcookie", :mcookie),
    ExecutableProduct(prefix, "mkswap", :mkswap),
    ExecutableProduct(prefix, "sfdisk", :sfdisk),
    ExecutableProduct(prefix, "column", :column),
    ExecutableProduct(prefix, "eject", :eject),
    ExecutableProduct(prefix, "scriptreplay", :scriptreplay),
    ExecutableProduct(prefix, "fstrim", :fstrim),
    ExecutableProduct(prefix, "readprofile", :readprofile),
    ExecutableProduct(prefix, "chrt", :chrt),
    ExecutableProduct(prefix, "agetty", :agetty),
    ExecutableProduct(prefix, "prlimit", :prlimit),
    ExecutableProduct(prefix, "namei", :namei),
    ExecutableProduct(prefix, "unshare", :unshare),
    ExecutableProduct(prefix, "mkfs", :mkfs_minix),
    ExecutableProduct(prefix, "wipefs", :wipefs),
    ExecutableProduct(prefix, "ipcs", :ipcs),
    ExecutableProduct(prefix, "uuidparse", :uuidparse),
    ExecutableProduct(prefix, "last", :last),
    ExecutableProduct(prefix, "colrm", :colrm),
    ExecutableProduct(prefix, "look", :look),
    ExecutableProduct(prefix, "fsck", :fsck_minix),
    ExecutableProduct(prefix, "wdctl", :wdctl),
    ExecutableProduct(prefix, "logger", :logger),
    ExecutableProduct(prefix, "lsipc", :lsipc),
    LibraryProduct(prefix, "libfdisk", :libfdisk)
]

# Dependencies that must be installed before this package can be built
dependencies = [
    
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies)


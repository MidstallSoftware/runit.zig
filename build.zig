const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const runitSource = b.dependency("runit", .{});

    const headers = b.addWriteFiles();
    _ = headers.addCopyFile(runitSource.path("runit-2.1.2/src/direntry.h2"), "direntry.h");
    _ = headers.addCopyFile(runitSource.path("runit-2.1.2/src/iopause.h2"), "iopause.h");
    _ = headers.addCopyFile(runitSource.path("runit-2.1.2/src/hasflock.h2"), "hasflock.h");
    _ = headers.addCopyFile(runitSource.path("runit-2.1.2/src/hasmkffo.h2"), "hasmkffo.h");
    _ = headers.addCopyFile(runitSource.path("runit-2.1.2/src/hasshsgr.h2"), "hasshsgr.h");
    _ = headers.addCopyFile(runitSource.path("runit-2.1.2/src/hassgact.h2"), "hassgact.h");
    _ = headers.addCopyFile(runitSource.path("runit-2.1.2/src/hassgprm.h2"), "hassgprm.h");
    _ = headers.addCopyFile(runitSource.path("runit-2.1.2/src/haswaitp.h2"), "haswaitp.h");
    _ = headers.addCopyFile(runitSource.path("runit-2.1.2/src/reboot_system.h2"), "reboot_system.h");
    _ = headers.addCopyFile(runitSource.path("runit-2.1.2/src/select.h2"), "select.h");
    _ = headers.addCopyFile(runitSource.path("runit-2.1.2/src/uint64.h2"), "uint64.h");

    const byte = b.addStaticLibrary(.{
        .name = "byte",
        .target = target,
        .optimize = optimize,
        .link_libc = true,
    });

    byte.addIncludePath(.{
        .generated = &headers.generated_directory,
    });

    byte.addIncludePath(runitSource.path("runit-2.1.2/src"));

    byte.addCSourceFiles(.{
        .root = runitSource.path("runit-2.1.2/src"),
        .files = &.{
            "byte_chr.c",
            "byte_copy.c",
            "byte_cr.c",
            "byte_diff.c",
            "byte_rchr.c",
            "fmt_uint.c",
            "fmt_uint0.c",
            "fmt_ulong.c",
            "scan_ulong.c",
            "str_chr.c",
            "str_diff.c",
            "str_len.c",
            "str_start.c",
        },
    });

    const time = b.addStaticLibrary(.{
        .name = "time",
        .target = target,
        .optimize = optimize,
        .link_libc = true,
    });

    time.addIncludePath(.{
        .generated = &headers.generated_directory,
    });

    time.addIncludePath(runitSource.path("runit-2.1.2/src"));

    time.addCSourceFiles(.{
        .root = runitSource.path("runit-2.1.2/src"),
        .files = &.{
            "iopause.c",
            "tai_now.c",
            "tai_pack.c",
            "tai_sub.c",
            "tai_unpack.c",
            "taia_add.c",
            "taia_approx.c",
            "taia_frac.c",
            "taia_less.c",
            "taia_now.c",
            "taia_pack.c",
            "taia_sub.c",
            "taia_uint.c",
        },
    });

    const unix = b.addStaticLibrary(.{
        .name = "unix",
        .target = target,
        .optimize = optimize,
        .link_libc = true,
    });

    unix.addIncludePath(.{
        .generated = &headers.generated_directory,
    });

    unix.addIncludePath(runitSource.path("runit-2.1.2/src"));

    unix.addCSourceFiles(.{
        .files = &.{
            "src/pathexec_run.c",
            "src/prot.c",
            "src/seek_set.c",
        },
    });

    unix.addCSourceFiles(.{
        .root = runitSource.path("runit-2.1.2/src"),
        .files = &.{
            "alloc.c",
            "alloc_re.c",
            "buffer.c",
            "buffer_0.c",
            "buffer_1.c",
            "buffer_2.c",
            "buffer_get.c",
            "buffer_put.c",
            "buffer_read.c",
            "buffer_write.c",
            "coe.c",
            "env.c",
            "error.c",
            "error_str.c",
            "fd_copy.c",
            "fd_move.c",
            "fifo.c",
            "lock_ex.c",
            "lock_exnb.c",
            "ndelay_off.c",
            "ndelay_on.c",
            "open_append.c",
            "open_read.c",
            "open_trunc.c",
            "open_write.c",
            "openreadclose.c",
            "pathexec_env.c",
            "readclose.c",
            "sgetopt.c",
            "sig.c",
            "sig_block.c",
            "sig_catch.c",
            "sig_pause.c",
            "stralloc_cat.c",
            "stralloc_catb.c",
            "stralloc_cats.c",
            "stralloc_eady.c",
            "stralloc_opyb.c",
            "stralloc_opys.c",
            "stralloc_pend.c",
            "strerr_die.c",
            "strerr_sys.c",
            "subgetopt.c",
            "wait_nohang.c",
            "wait_pid.c",
        },
    });

    const runsv = b.addExecutable(.{
        .name = "runsv",
        .target = target,
        .optimize = optimize,
        .link_libc = true,
    });

    runsv.linkLibrary(byte);
    runsv.linkLibrary(time);
    runsv.linkLibrary(unix);

    runsv.addIncludePath(.{
        .generated = &headers.generated_directory,
    });

    runsv.addIncludePath(runitSource.path("runit-2.1.2/src"));

    runsv.addCSourceFile(.{
        .file = runitSource.path("runit-2.1.2/src/runsv.c"),
    });

    b.installArtifact(runsv);

    const runsvdir = b.addExecutable(.{
        .name = "runsvdir",
        .target = target,
        .optimize = optimize,
        .link_libc = true,
    });

    runsvdir.linkLibrary(byte);
    runsvdir.linkLibrary(time);
    runsvdir.linkLibrary(unix);

    runsvdir.addIncludePath(.{
        .generated = &headers.generated_directory,
    });

    runsvdir.addIncludePath(runitSource.path("runit-2.1.2/src"));

    runsvdir.addCSourceFile(.{
        .file = runitSource.path("runit-2.1.2/src/runsvdir.c"),
    });

    b.installArtifact(runsvdir);

    const runsvstat = b.addExecutable(.{
        .name = "runsvstat",
        .target = target,
        .optimize = optimize,
        .link_libc = true,
    });

    runsvstat.linkLibrary(byte);
    runsvstat.linkLibrary(time);
    runsvstat.linkLibrary(unix);

    runsvstat.addIncludePath(.{
        .generated = &headers.generated_directory,
    });

    runsvstat.addIncludePath(runitSource.path("runit-2.1.2/src"));

    runsvstat.addCSourceFile(.{
        .file = runitSource.path("runit-2.1.2/src/runsvstat.c"),
    });

    b.installArtifact(runsvstat);

    const runsvctrl = b.addExecutable(.{
        .name = "runsvctrl",
        .target = target,
        .optimize = optimize,
        .link_libc = true,
    });

    runsvctrl.linkLibrary(byte);
    runsvctrl.linkLibrary(unix);

    runsvctrl.addIncludePath(.{
        .generated = &headers.generated_directory,
    });

    runsvctrl.addIncludePath(runitSource.path("runit-2.1.2/src"));

    runsvctrl.addCSourceFile(.{
        .file = runitSource.path("runit-2.1.2/src/runsvctrl.c"),
    });

    b.installArtifact(runsvctrl);

    const sv = b.addExecutable(.{
        .name = "sv",
        .target = target,
        .optimize = optimize,
        .link_libc = true,
    });

    sv.linkLibrary(byte);
    sv.linkLibrary(time);
    sv.linkLibrary(unix);

    sv.addIncludePath(.{
        .generated = &headers.generated_directory,
    });

    sv.addIncludePath(runitSource.path("runit-2.1.2/src"));

    sv.addCSourceFile(.{
        .file = runitSource.path("runit-2.1.2/src/sv.c"),
    });

    b.installArtifact(sv);

    const runit = b.addExecutable(.{
        .name = "runit",
        .target = target,
        .optimize = optimize,
        .link_libc = true,
    });

    runit.linkLibrary(byte);
    runit.linkLibrary(unix);

    runit.addIncludePath(.{
        .generated = &headers.generated_directory,
    });

    runit.addIncludePath(runitSource.path("runit-2.1.2/src"));

    runit.addCSourceFile(.{
        .file = runitSource.path("runit-2.1.2/src/runit.c"),
    });

    b.getInstallStep().dependOn(&b.addInstallArtifact(runit, .{
        .dest_dir = .{
            .override = .{
                .custom = "sbin",
            },
        },
    }).step);

    const runitInit = b.addExecutable(.{
        .name = "runit-init",
        .target = target,
        .optimize = optimize,
        .link_libc = true,
    });

    runitInit.linkLibrary(byte);
    runitInit.linkLibrary(unix);

    runitInit.addIncludePath(.{
        .generated = &headers.generated_directory,
    });

    runitInit.addIncludePath(runitSource.path("runit-2.1.2/src"));

    runitInit.addCSourceFile(.{
        .file = runitSource.path("runit-2.1.2/src/runit-init.c"),
    });

    b.getInstallStep().dependOn(&b.addInstallArtifact(runitInit, .{
        .dest_dir = .{
            .override = .{
                .custom = "sbin",
            },
        },
    }).step);
}

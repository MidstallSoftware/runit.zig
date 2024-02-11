const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const runitSource = b.dependency("runit", .{});

    const headers = b.addWriteFiles();
    _ = headers.addCopyFile(runitSource.path("runit-2.1.2/src/iopause.h2"), "iopause.h");
    _ = headers.addCopyFile(runitSource.path("runit-2.1.2/src/hasflock.h2"), "hasflock.h");
    _ = headers.addCopyFile(runitSource.path("runit-2.1.2/src/hasmkffo.h2"), "hasmkffo.h");
    _ = headers.addCopyFile(runitSource.path("runit-2.1.2/src/hasshsgr.h2"), "hasshsgr.h");
    _ = headers.addCopyFile(runitSource.path("runit-2.1.2/src/hassgact.h2"), "hassgact.h");
    _ = headers.addCopyFile(runitSource.path("runit-2.1.2/src/hassgprm.h2"), "hassgprm.h");
    _ = headers.addCopyFile(runitSource.path("runit-2.1.2/src/haswaitp.h2"), "haswaitp.h");
    _ = headers.addCopyFile(runitSource.path("runit-2.1.2/src/reboot_system.h2"), "reboot_system.h");
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
        .files = &.{
            runitSource.path("runit-2.1.2/src/byte_chr.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/byte_copy.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/byte_cr.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/byte_diff.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/byte_rchr.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/fmt_uint.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/fmt_uint0.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/fmt_ulong.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/scan_ulong.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/str_chr.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/str_diff.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/str_len.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/str_start.c").getPath(runitSource.builder),
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
            runitSource.path("runit-2.1.2/src/alloc.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/alloc_re.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/buffer.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/buffer_0.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/buffer_1.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/buffer_2.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/buffer_get.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/buffer_put.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/buffer_read.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/buffer_write.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/coe.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/env.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/error.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/error_str.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/fd_copy.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/fd_move.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/fifo.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/lock_ex.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/lock_exnb.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/ndelay_off.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/ndelay_on.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/open_append.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/open_read.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/open_trunc.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/open_write.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/openreadclose.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/pathexec_env.c").getPath(runitSource.builder),
            b.pathFromRoot("src/pathexec_run.c"),
            b.pathFromRoot("src/prot.c"),
            runitSource.path("runit-2.1.2/src/readclose.c").getPath(runitSource.builder),
            b.pathFromRoot("src/seek_set.c"),
            runitSource.path("runit-2.1.2/src/sgetopt.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/sig.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/sig_block.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/sig_catch.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/sig_pause.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/stralloc_cat.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/stralloc_catb.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/stralloc_cats.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/stralloc_pend.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/strerr_die.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/strerr_sys.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/subgetopt.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/wait_nohang.c").getPath(runitSource.builder),
            runitSource.path("runit-2.1.2/src/wait_pid.c").getPath(runitSource.builder),
        },
    });

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

    runit.addCSourceFiles(.{
        .files = &.{
            runitSource.path("runit-2.1.2/src/runit.c").getPath(runitSource.builder),
        },
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

    runitInit.addCSourceFiles(.{
        .files = &.{
            runitSource.path("runit-2.1.2/src/runit-init.c").getPath(runitSource.builder),
        },
    });

    b.getInstallStep().dependOn(&b.addInstallArtifact(runitInit, .{
        .dest_dir = .{
            .override = .{
                .custom = "sbin",
            },
        },
    }).step);
}

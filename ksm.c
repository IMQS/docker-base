/*
 * libksm.so - LD_PRELOAD shim that marks all memory of a process as mergeable
 * by KSM (Kernel Samepage Merging).
 *
 * Usage:
 *   LD_PRELOAD=/usr/local/lib/libksm.so <program> [args...]
 *
 * KSM must be running on the host for this to have any effect:
 *   echo 1 > /sys/kernel/mm/ksm/run
 *
 * Requires Linux >= 6.4. prctl(PR_SET_MEMORY_MERGE, 1) makes the kernel treat
 * every current and future anonymous mapping of the process as mergeable, and
 * the setting is inherited by forked children.
 */

#define _GNU_SOURCE

#include <errno.h>
#include <stdio.h>
#include <string.h>
#include <sys/prctl.h>

__attribute__((constructor)) static void ksm_init(void)
{
	if (prctl(PR_SET_MEMORY_MERGE, 1, 0, 0, 0) != 0)
		fprintf(stderr, "libksm: PR_SET_MEMORY_MERGE failed: %s\n", strerror(errno));
}

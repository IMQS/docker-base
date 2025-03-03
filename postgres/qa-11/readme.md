This Postgres setup is used by automated testing machines.

The crucial thing that we do here, is we disable fsync.
Ordinarily, that's an insane thing to do. But we throw these databases away all the time,
and we rely on snapshots of them, so it's OK for persistence to be unreliable.
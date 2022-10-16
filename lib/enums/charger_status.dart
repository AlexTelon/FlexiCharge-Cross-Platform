/// TODO: Make use of this Enum instead of hardcoding strings!

enum ChargerStatus {
  Available,
  Unavailable,
  Reserved, // We do no use this as of now, leave it to the backend
  Occupied, // Does not work at the moment?
  Faulted, // Only to read, never update to this status
  Rejected, // Only to read, never update to this status
  Accepted, // Only to read, never update to this status
}

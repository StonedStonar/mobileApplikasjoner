class APIPath{

  ///Gets the path of a job
  ///[uId] the id of the user.
  ///[jobId] the id of the job.
  ///Returns the job path.
  static String getJobPath(String uId, String jobId) => "users/$uId/jobs/$jobId";

  ///Gets path of all the jobs of the user.
  ///[uId] the user id.
  static String getJobsOfUser(String uId) => "users/$uId/jobs";
}
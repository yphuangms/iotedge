// Copyright (c) Microsoft. All rights reserved.

namespace Microsoft.Azure.WebJobs.Extensions.EdgeHub
{
    using Microsoft.Azure.WebJobs.Extensions.EdgeHub.Config;
    using Microsoft.Azure.WebJobs.Hosting;

    public class EdgeHubWebJobsStartup : IWebJobsStartup
    {
        public void Configure(IWebJobsBuilder builder) => builder.AddEdge();
    }
}

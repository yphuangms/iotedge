// Copyright (c) Microsoft. All rights reserved.

namespace Microsoft.Azure.WebJobs.Extensions.EdgeHub
{
    using System;

    /// <summary>
    /// An error detection strategy that delegates the detection to a lambda.
    /// </summary>
    public class DelegateErrorDetectionStrategy : ITransientErrorDetectionStrategy
    {
        readonly Func<Exception, bool> underlying;

        public DelegateErrorDetectionStrategy(Func<Exception, bool> isTransient)
        {
            this.underlying = isTransient ?? throw new ArgumentException("isTransient value can not be null.");
        }

        public bool IsTransient(Exception ex) => this.underlying(ex);
    }
}

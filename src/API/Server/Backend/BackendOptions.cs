﻿using System;

namespace CodeProject.SenseAI.API.Server.Backend
{
    /// <summary>
    /// Options for Queue Processing
    /// </summary>
    public class BackendOptions
    {
        /// <summary>
        /// Get or set the max time to get a response.
        /// </summary>
        public TimeSpan ResponseTimeout { get; set; } = TimeSpan.FromSeconds(60);
        public TimeSpan CommandDequeueTimeout { get; set; } = TimeSpan.FromSeconds(10);

        /// <summary>
        /// Get or set the max number of requests that can be queued.
        /// </summary>
        public int MaxQueueLength { get; set; } = 20;

        public string ImageTempDir { get; set; } = "CodeProject.SenseAI.TempImages";
    }
}

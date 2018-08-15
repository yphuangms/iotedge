// Copyright (c) Microsoft. All rights reserved.

namespace Microsoft.Azure.WebJobs.Extensions.EdgeHub.Config
{
    using System;
    using Microsoft.Azure.Devices.Client;
    using Microsoft.Azure.WebJobs.Description;
    using Microsoft.Azure.WebJobs.Host.Config;
    using Newtonsoft.Json;

    /// <summary>
    /// Extension configuration provider used to register EdgeHub triggers and binders
    /// </summary>
    [Extension("EdgeHub")]
    class EdgeHubExtensionConfigProvider : IExtensionConfigProvider
    {
        public void Initialize(ExtensionConfigContext context)
        {
            if (context == null)
            {
                throw new ArgumentNullException(nameof(context));
            }

            var bindingProvider = new EdgeHubTriggerBindingProvider();
            context.AddBindingRule<EdgeHubTriggerAttribute>()
                .BindToTrigger(bindingProvider);

            var rule = context.AddBindingRule<EdgeHubAttribute>();
            rule.BindToCollector<Message>(typeof(EdgeHubCollectorBuilder));

            context.AddConverter<Message, string>(this.MessageConverter);
            context.AddConverter<string, Message>(this.ConvertToMessage);
        }

        Message ConvertToMessage(string str)
        {
            return JsonConvert.DeserializeObject<Message>(str);
        }

        string MessageConverter(Message msg)
        {
            return JsonConvert.SerializeObject(msg);
        }
    }
}

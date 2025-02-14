FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
COPY publish_output/ .
ENTRYPOINT ["dotnet", "mvc.dll"]

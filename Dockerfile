FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /app

# Копируем ВСЁ из app-src в текущую директорию
COPY ./app-src/ .

# Восстанавливаем и публикуем напрямую из .sln
RUN dotnet restore ExhibitionApp.sln
RUN dotnet publish ExhibitionApp.sln -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:9.0-alpine
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 8080
CMD ["dotnet", "ExhibitionApp.dll"]

# --- Стадия сборки (build) ---
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Копируем файл решения и файлы проектов
COPY app-src/ExhibitionApp.sln .
COPY app-src/ExhibitionApp/*.csproj ./ExhibitionApp/
RUN dotnet restore

# Копируем весь исходный код
COPY app-src/ .

# Публикуем приложение
WORKDIR /src/ExhibitionApp
RUN dotnet publish -c Release -o /app/publish

# --- Стадия выполнения (runtime) ---
FROM mcr.microsoft.com/dotnet/aspnet:9.0-alpine
WORKDIR /app
COPY --from=build /app/publish .

EXPOSE 8080
CMD ["dotnet", "ExhibitionApp.dll"]

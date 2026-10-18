FROM python:3.10-slim

# Create a non-root user for security requirements
RUN useradd -m -u 1000 user
USER user
ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH

WORKDIR $HOME/app

# Install project dependencies
COPY --chown=user:user requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application files
COPY --chown=user:user . .

# Expose ModelScope's default web app port
EXPOSE 7860

# Command to run your app entrypoint
CMD ["python", "-m", "app"]

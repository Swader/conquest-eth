<script lang="ts">
  export let address: string;
  export let offset: number = 0;
  export let style: string | undefined = undefined;

  import {Blockie} from '$lib/utils/eth/blockie';

  $: uri =
    address.toLowerCase() === '0xdeaddeaddeaddeaddeaddeaddeaddeaddeaddead' ||
    address.toLowerCase() === '0xae5686440a11098211bb2cc60de2acb149b9defb'
      ? 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAgAAAAICAIAAABLbSncAAAAAXNSR0IArs4c6QAAAC5JREFUCJljYCAeXK/excDAwPL//38scgy7GOASaAwmXAYyYjWKkZERoReZxAcA+csbkMtRTQoAAAAASUVORK5CYII='
      : Blockie.getURI(address, offset);
</script>

<img {style} src={uri} alt={address} />

<style>
  img {
    image-rendering: -moz-crisp-edges;
    image-rendering: -webkit-crisp-edges;
    image-rendering: pixelated;
    image-rendering: crisp-edges;
  }
</style>
